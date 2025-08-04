package com.infinite.jsf.test;

import com.infinite.jsf.insurance.controller.CreateInsuranceController;

public class TesstInsurance {

	public static void main(String[] args) {

		CreateInsuranceController create = new CreateInsuranceController();
		create.findAllPlanDetailsByPlanId("PLA001");
	}

}
