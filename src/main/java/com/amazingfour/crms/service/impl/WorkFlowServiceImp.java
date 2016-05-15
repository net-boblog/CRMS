package com.amazingfour.crms.service.impl;

import org.activiti.engine.HistoryService;
import org.activiti.engine.RepositoryService;
import org.activiti.engine.RuntimeService;
import org.activiti.engine.repository.Deployment;
import org.activiti.engine.runtime.ProcessInstance;
import org.activiti.engine.runtime.ProcessInstanceQuery;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.HashMap;
import java.util.List;
import java.util.Map;


/**
 * Created by hmaccelerate on 2016/4/29.
 */
@Service
public class WorkFlowServiceImp {
    @Autowired
    private RepositoryService repositoryService;
    @Autowired
    private RuntimeService runtimeService;
    @Autowired
    private HistoryService historyService;
    /**
     * 部署单独的流程
     *
     * @param resource
     */
    public void deploySingleProcess(String resource) {
        Deployment deployment = repositoryService.
                createDeployment().addClasspathResource(resource).name("auditing-process").deploy();
    }


    public Map<String, Object> showAllRunningProcess(int firstResults, int maxResults) {
        ProcessInstanceQuery processInstanceQuery = runtimeService.createProcessInstanceQuery().active();
        Long total = processInstanceQuery.count();
        List<ProcessInstance> processInstanceList = processInstanceQuery.listPage(firstResults, maxResults);
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("processInstanceList", processInstanceList);
        map.put("total", total);
        return map;
    }

    public Map<String, Object> showInvolvingProcess(){
//        ProcessInstanceQuery processInstanceQuery = runtimeService.createProcessInstanceQuery().
//        historyService.createHistoricProcessInstanceQuery().involvedUser("").unfinished().listPage();
        Map<String, Object> map = new HashMap<String, Object>();
//        map.put("processInstanceList", processInstanceList);
//        map.put("total", total);
        return map;
    }
}

