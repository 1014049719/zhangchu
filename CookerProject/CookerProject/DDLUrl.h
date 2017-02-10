//
//  DDLUrl.h
//  CookerProject
//
//  Created by vera on 15-1-21.
//  Copyright (c) 2015年 vera. All rights reserved.
//

#ifndef CookerProject_DDLUrl_h
#define CookerProject_DDLUrl_h

//首页-日期
#define Main_Date_Url @"http://112.124.32.151:8080/HandheldKitchen/api/more/tblcalendaralertinfo!get.do?year=2015&month=01&day=14&page=1&pageRecord=10&is_traditional=0"

//首页-数据
#define Main_FoodData_url @"http://112.124.32.151:8080/HandheldKitchen/api/more/tblcalendaralertinfo!getHomePage.do?phonetype=2&page=1&pageRecord=10&user_id=&is_traditional=0"

//对症食疗 -- 科
#define FoodTrateOffice_url @"http://112.124.32.151:8080/HandheldKitchen/api/vegetable/tbloffice!getOffice.do?is_traditional=0"

//对症食疗 -- 疾病
#define FoodTrateDisease_url @"http://112.124.32.151:8080/HandheldKitchen/api/vegetable/tbldisease!getDisease.do?officeId=%@&is_traditional=0"

//对症食疗 -- 疾病 -- 疾病详情
#define FoodTrateDiseaseDetail_url @"http://112.124.32.151:8080/HandheldKitchen/api/vegetable/tbldisease!getVegetable.do?diseaseId=%@&page=1&pageRecord=8&phonetype=0&is_traditional=0"

//食物详情界面
#define FoodDetail_url @"http://112.124.32.151:8080/HandheldKitchen/api/vegetable/tblvegetable!getTblVegetables.do?vegetable_id=%@&phonetype=2&user_id=&is_traditional=0"

//食物详情界面 --- 材料
#define FoodDetail_Material_url @"http://112.124.32.151:8080/HandheldKitchen/api/vegetable/tblvegetable!getIntelligentChoice.do?vegetable_id=%@&type=1&phonetype=0&is_traditional=0"

//**************  食材大全 ******************/
//食材大全 -- 左边
#define FoodMaterial_left_url @"http://112.124.32.151:8080/HandheldKitchen/api/more/tblmmaterialtype!getlMmaterialType.do?is_traditional=0"

//食材大全 -- 右边
#define FoodMaterial_right_url @"http://112.124.32.151:8080/HandheldKitchen/api/more/tblmmaterialtype!getMaterialList.do?materialTypeId=%@&page=1&pageRecord=10&is_traditional=0"

//**************  万道美食任您选 ******************/
//tabbar上的数据
#define FoodRandomTabbarView_url @"http://112.124.32.151:8080/HandheldKitchen/api/vegetable/tblvegetablecatalog!get.do?page=1&pageRecord=18&phonetype=2&is_traditional=0"

//数据
#define FoodRandomTabbarDetailView_url @"http://112.124.32.151:8080/HandheldKitchen/api/vegetable/tblvegetable!getInfo.do?catalog_id=%@&page=1&pageRecord=8&phonetype=0&user_id=&is_traditional=0"

//摇一摇接口
#define FoodShakeRandom_url @"http://112.124.32.151:8080/HandheldKitchen/api/vegetable/tblrandomvegetable!get.do?count=1&user_id=16681&phonetype=2&is_traditional=0"

//**************  智能选菜 ******************/
//智能选菜详情界面
#define FoodIntelligentSelectFoodDetail_url @"http://112.124.32.151:8080/HandheldKitchen/api/vegetable/tblvegetable!getChooseFood.do?material_id=%@&page=1&pageRecord=8&phonetype=0&user_id=&is_traditional=0"



#endif
