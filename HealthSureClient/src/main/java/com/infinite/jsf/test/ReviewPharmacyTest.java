package com.infinite.jsf.test;

//import com.infinite.jsf.pharmacy.controller.ReviewPharmacyController;
import com.infinite.jsf.admin.controller.ReviewPharmacyController;

import com.infinite.jsf.admin.dao.ReviewPharmacyaDao;
import com.infinite.jsf.admin.daoImpl.ReviewPharmacyaDaoImpl;
import com.infinite.jsf.admin.exception.ReviewPharmacyException;

public class ReviewPharmacyTest {
	public static void main(String[] args) {
		
		ReviewPharmacyController controller=new ReviewPharmacyController();
		ReviewPharmacyaDao dao=new ReviewPharmacyaDaoImpl();
		System.out.println("===================");
		try {
			dao.reviewPharmacyDetails();
		} catch (ReviewPharmacyException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		for(int i=0;i<10;i++) {
			try {
				dao.reviewPharmacyDetails();
			} catch (ReviewPharmacyException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
//		controller.showPharmacyAllForReview().forEach(System.out::println);
//		System.out.println(controller.showPharmacyAllForReview().get(0).getEquipments());

//	dao.reviewPharmacyDetails().forEach(System.out::println);
		
//ReviewPharmacyController admincontrollerController=new ReviewPharmacyController();
//admincontrollerController.showPharmacyAllForReview().forEach(System.out::println);
//	System.out.println(admincontrollerController.showPharmacyAllForReview().get(0).getStatus());

	}

}
