package com.infinite.jsf.test;

import com.infinite.jsf.insurance.controller.CreateInsuranceController;
import com.infinite.jsf.insurance.dao.InsuranceCoverageOptionDao;
import com.infinite.jsf.insurance.daoImpl.InsuranceCoverageOptionDaoImpl;
import com.infinite.jsf.insurance.exception.InsuranceCoverageOptionException;
import com.infinite.jsf.insurance.model.InsuranceCoverageOption;

public class CoverageTest {
	public static void main(String[] args) {
		CreateInsuranceController controller = new CreateInsuranceController();
		InsuranceCoverageOptionDao dao = new InsuranceCoverageOptionDaoImpl();
		try {
			dao.findAllInsuranceCoverageOptionsByPlanId("PLA001").forEach(System.out::println);
		} catch (InsuranceCoverageOptionException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

	}

}
