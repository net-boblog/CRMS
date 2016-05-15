package com.amazingfour.crms.controller;

import com.amazingfour.crms.service.impl.WorkFlowServiceImp;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

/**
 * Created by hmaccelerate on 2016/4/29.
 */
@RequestMapping("process")
public class WorkFlowController {
    @Autowired
    private WorkFlowServiceImp workFlowServiceImp;

    @RequestMapping("showAllRunningProcess")
    public ModelAndView showAllRunningProcess(){
        ModelAndView modelAndView=new ModelAndView("process/processMain");
//        workFlowServiceImp.showRunningProcess();
        return modelAndView;
    }


}
