package com.amazingfour.crms.service.impl;

import com.amazingfour.common.utils.WorkflowUtils;
import com.amazingfour.crms.domain.CloudFile;
import com.amazingfour.crms.service.CloudFileService;
import com.amazingfour.crms.service.UserService;
import org.activiti.engine.*;
import org.activiti.engine.delegate.Expression;
import org.activiti.engine.history.HistoricProcessInstance;
import org.activiti.engine.history.HistoricTaskInstance;
import org.activiti.engine.identity.User;
import org.activiti.engine.impl.RepositoryServiceImpl;
import org.activiti.engine.impl.bpmn.behavior.UserTaskActivityBehavior;
import org.activiti.engine.impl.persistence.entity.ProcessDefinitionEntity;
import org.activiti.engine.impl.pvm.delegate.ActivityBehavior;
import org.activiti.engine.impl.pvm.process.ActivityImpl;
import org.activiti.engine.impl.task.TaskDefinition;
import org.activiti.engine.repository.ProcessDefinition;
import org.activiti.engine.runtime.Execution;
import org.activiti.engine.runtime.ProcessInstance;
import org.activiti.engine.task.Task;
import org.activiti.engine.task.TaskInfoQuery;
import org.activiti.engine.task.TaskQuery;
import org.apache.commons.beanutils.PropertyUtils;
import org.apache.commons.lang3.StringUtils;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.io.InputStream;
import java.lang.reflect.InvocationTargetException;
import java.util.*;


/**
 * Created by hmaccelerate on 2016/4/28.
 */
@Service
public class TaskServiceImp {
    @Autowired
    private RepositoryService repositoryService;
    @Autowired
    private RuntimeService runtimeService;
    @Autowired
    private TaskService taskService;
    @Autowired
    private IdentityService identityService;
    @Autowired
    private HistoryService historyService;
    @Autowired
    private CloudFileService cloudFileService;
    @Autowired
    private UserService userService;
    static Logger logger = Logger.getLogger(TaskServiceImp.class.getName());

    /**
     * 启动流程实例，将业务和流程实例关联
     *
     * @param cloudFile
     */
    public CloudFile startWorkFlow(CloudFile cloudFile, Long userId) {
        try {
            String bussinessKeyId = cloudFile.getBussinessKey();
            // 用来设置启动流程的人员ID，引擎会自动把用户ID保存到activiti:initiator中
            identityService.setAuthenticatedUserId(userId.toString());
            ProcessInstance instance = runtimeService.startProcessInstanceByKey("auditing-process", bussinessKeyId);
            String instanceId = instance.getProcessInstanceId();
            cloudFile.setInstanceId(instanceId);

        } finally {
            identityService.setAuthenticatedUserId(null);
        }
        return cloudFile;
    }


    /**
     * 配置在流程图中，为任务设置候选人
     *
     * @param roleName
     * @return
     */
    public List<String> setTaskUsers(String roleName) {
        List<Integer> userIdList = userService.findByRoleName(roleName);
        List<String> idList = new ArrayList<String>();
        for (Integer num : userIdList) {
            idList.add(num.toString());
        }
        return idList;
    }

    /**
     * 查询待领任务/查询待办任务
     *
     * @param userId
     * @param firstResult
     * @param maxresult
     * @return
     */
    public Map<String, Object> findToDoTasks(String userId, int firstResult, int maxresult, int taskState) {
        List<CloudFile> results = new ArrayList<CloudFile>();
//        根据当前人id查询相关任务
        TaskQuery taskQuery = null;
        if (taskState == 0) {
            taskQuery = taskService.createTaskQuery().taskCandidateUser(userId);
        } else {
            taskQuery = taskService.createTaskQuery().taskAssignee(userId);
        }
        long count = taskQuery.count();
        int total = new Long(count).intValue();
        List<Task> taskList = taskQuery.listPage(firstResult, maxresult);
//        根据流程id查询将要审核的业务实体
        for (Task task : taskList) {
            String processInstanceId = task.getProcessInstanceId();
            ProcessInstance processInstance = runtimeService.createProcessInstanceQuery().processInstanceId(processInstanceId).active().singleResult();
            String bussinessKey = processInstance.getBusinessKey();
            CloudFile cloudFile = cloudFileService.findByBussinessKey(bussinessKey);
            cloudFile.setTask(task);
            task.getId();
            results.add(cloudFile);
        }
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("taskList", results);
        map.put("total", total);
        return map;
    }

    /**
     * 签收任务
     *
     * @param taskId
     * @param userId
     */
    public void claimTask(String taskId, Long userId) {
        taskService.claim(taskId, userId.toString());
    }

    /**
     * 处理任务：审核通过/拒绝  申请二级审核
     *
     * @param taskId
     * @param fileCondition
     * @param reply
     */
    public void dealWithTask(String taskId, String fileCondition, String reply, String reseaon) {
        Map<String, Object> taskVariables = new HashMap<String, Object>();
        if (fileCondition.equals("normal")) {
            taskVariables.put("reply", reply);
            if (reply.equals("no")) {
                taskVariables.put("reseaon", reseaon);
            }
        }
        taskVariables.put("fileCondition", fileCondition);
        taskService.complete(taskId, taskVariables);
    }

    /**
     * 显示历史任务
     *
     * @param userId
     * @param firstResult
     * @param maxresult
     * @return
     */
    public Map<String, Object> showHistoryTasks(String userId, int firstResult, int maxresult) {
        List<CloudFile> results = new ArrayList<CloudFile>();
        TaskInfoQuery taskInfoQuery = historyService.createHistoricTaskInstanceQuery().taskAssignee(userId).finished();
        List<HistoricTaskInstance> taskInstanceList = taskInfoQuery.listPage(firstResult, maxresult);
        Long count = taskInfoQuery.count();
        int total = new Long(count).intValue();
        //        根据流程id查询将要审核的业务实体
        for (HistoricTaskInstance historicTaskInstance : taskInstanceList) {
            String processInstanceId = historicTaskInstance.getProcessInstanceId();
//            ProcessInstance processInstance = runtimeService.createProcessInstanceQuery().processInstanceId(processInstanceId).active().singleResult();
            HistoricProcessInstance historicProcessInstance = historyService.createHistoricProcessInstanceQuery().processInstanceId(processInstanceId).singleResult();
            String bussinessKey = historicProcessInstance.getBusinessKey();
            CloudFile cloudFile = cloudFileService.findByBussinessKey(bussinessKey);
            results.add(cloudFile);
        }
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("taskList", results);
        map.put("total", total);
        return map;
    }

    /**
     * 获取图片资源流
     *
     * @param resourceType
     * @param bussinessKey
     */
    public InputStream loadResource(String resourceType, String bussinessKey) {
        InputStream resourceAsStream = null;
        if (StringUtils.isNotBlank(bussinessKey)) {
//                ProcessInstance processInstance = runtimeService.createProcessInstanceQuery().processInstanceId(processInstanceId).singleResult();
            ProcessInstance processInstance = runtimeService.createProcessInstanceQuery().processInstanceBusinessKey(bussinessKey).singleResult();
            ProcessDefinition singleResult = repositoryService.createProcessDefinitionQuery()
                    .processDefinitionId(processInstance.getProcessDefinitionId()).singleResult();
            String resourceName = "";
            if (resourceType.equals("image")) {
                resourceName = singleResult.getDiagramResourceName();
            } else if (resourceType.equals("xml")) {
                resourceName = singleResult.getResourceName();
            }
            resourceAsStream = repositoryService.getResourceAsStream(singleResult.getDeploymentId(), resourceName);
        }
        return resourceAsStream;
    }

    /**
     * 流程跟踪图
     *
     * @param bussinessKey
     * @return
     * @throws IllegalAccessException
     * @throws NoSuchMethodException
     * @throws InvocationTargetException
     */
    public List<Map<String, Object>> traceProcess(String bussinessKey) throws Exception {
        Execution execution = runtimeService.createExecutionQuery().processInstanceBusinessKey(bussinessKey).singleResult();//执行实例
        Object property = PropertyUtils.getProperty(execution, "activityId");
        String activityId = "";
        if (property != null) {
            activityId = property.toString();
        }
        ProcessInstance processInstance = runtimeService.createProcessInstanceQuery().processInstanceBusinessKey(bussinessKey)
                .singleResult();
        ProcessDefinitionEntity processDefinition = (ProcessDefinitionEntity) ((RepositoryServiceImpl) repositoryService)
                .getDeployedProcessDefinition(processInstance.getProcessDefinitionId());
        List<ActivityImpl> activitiList = processDefinition.getActivities();//获得当前任务的所有节点

        List<Map<String, Object>> activityInfos = new ArrayList<Map<String, Object>>();
        for (ActivityImpl activity : activitiList) {

            boolean currentActiviti = false;
            String id = activity.getId();

            // 当前节点
            if (id.equals(activityId)) {
                currentActiviti = true;
            }

            Map<String, Object> activityImageInfo = packageSingleActivitiInfo(activity, processInstance, currentActiviti);

            activityInfos.add(activityImageInfo);
        }

        return activityInfos;
    }


    /**
     * 封装输出信息，包括：当前节点的X、Y坐标、变量信息、任务类型、任务描述
     *
     * @param activity
     * @param processInstance
     * @param currentActiviti
     * @return
     */
    private Map<String, Object> packageSingleActivitiInfo(ActivityImpl activity, ProcessInstance processInstance,
                                                          boolean currentActiviti) throws Exception {
        Map<String, Object> vars = new HashMap<String, Object>();
        Map<String, Object> activityInfo = new HashMap<String, Object>();
        activityInfo.put("currentActiviti", currentActiviti);
        setPosition(activity, activityInfo);
        setWidthAndHeight(activity, activityInfo);

        Map<String, Object> properties = activity.getProperties();
        vars.put("任务类型", WorkflowUtils.parseToZhType(properties.get("type").toString()));

        ActivityBehavior activityBehavior = activity.getActivityBehavior();
        if (activityBehavior instanceof UserTaskActivityBehavior) {

            Task currentTask = null;

			/*
             * 当前节点的task
			 */
            if (currentActiviti) {
                currentTask = getCurrentTaskInfo(processInstance);
            }

			/*
             * 当前任务的分配角色
			 */
            UserTaskActivityBehavior userTaskActivityBehavior = (UserTaskActivityBehavior) activityBehavior;
            TaskDefinition taskDefinition = userTaskActivityBehavior.getTaskDefinition();
            Set<Expression> candidateGroupIdExpressions = taskDefinition.getCandidateGroupIdExpressions();
            if (!candidateGroupIdExpressions.isEmpty()) {

                // 任务的处理角色
                setTaskGroup(vars, candidateGroupIdExpressions);

                // 当前处理人
                if (currentTask != null) {
                    setCurrentTaskAssignee(vars, currentTask);
                }
            }
        }

        vars.put("节点说明", properties.get("documentation"));

        String description = activity.getProcessDefinition().getDescription();
        vars.put("描述", description);

        activityInfo.put("vars", vars);
        return activityInfo;
    }

    private void setTaskGroup(Map<String, Object> vars, Set<Expression> candidateGroupIdExpressions) {
        String roles = "";
        for (Expression expression : candidateGroupIdExpressions) {
            String expressionText = expression.getExpressionText();
            String roleName = identityService.createGroupQuery().groupId(expressionText).singleResult().getName();
            roles += roleName;
        }
        vars.put("任务所属角色", roles);
    }

    /**
     * 设置当前处理人信息
     *
     * @param vars
     * @param currentTask
     */
    private void setCurrentTaskAssignee(Map<String, Object> vars, Task currentTask) {
        String assignee = currentTask.getAssignee();
        if (assignee != null) {
            User assigneeUser = identityService.createUserQuery().userId(assignee).singleResult();
            String userInfo = assigneeUser.getFirstName() + " " + assigneeUser.getLastName();
            vars.put("当前处理人", userInfo);
        }
    }

    /**
     * 获取当前节点信息
     *
     * @param processInstance
     * @return
     */
    private Task getCurrentTaskInfo(ProcessInstance processInstance) {
        Task currentTask = null;
        try {
            String activitiId = (String) PropertyUtils.getProperty(processInstance, "activityId");

            currentTask = taskService.createTaskQuery().processInstanceId(processInstance.getId()).taskDefinitionKey(activitiId)
                    .singleResult();

        } catch (Exception e) {
        }
        return currentTask;
    }

    /**
     * 设置宽度、高度属性
     *
     * @param activity
     * @param activityInfo
     */
    private void setWidthAndHeight(ActivityImpl activity, Map<String, Object> activityInfo) {
        activityInfo.put("width", activity.getWidth());
        activityInfo.put("height", activity.getHeight());
    }

    /**
     * 设置坐标位置
     *
     * @param activity
     * @param activityInfo
     */
    private void setPosition(ActivityImpl activity, Map<String, Object> activityInfo) {
        activityInfo.put("x", activity.getX());
        activityInfo.put("y", activity.getY());
    }

    /**
     * 获得拒绝理由
     * @param instanceId
     * @return
     */
    public String getReseaon(String instanceId){
        String reseaon = (String) runtimeService.getVariable(instanceId, "reseaon");
        return reseaon;
    }

    public void dealWithAdjust(String instanceId,String next){
       Task task= taskService.createTaskQuery().processInstanceId(instanceId).singleResult();
        Map<String, Object> map=new HashMap<String, Object>();
        map.put("answer",next);
        taskService.complete(task.getId(),map);
    }


}
