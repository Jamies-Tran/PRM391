import 'package:flutter/material.dart';
import 'package:hci_201/model/food.dart';

class Category {
  String id;
  String title;
  String image;
  List<Food> foodList;
  bool isSelected = false;

  Category({this.id, this.title, this.image, this.foodList});

  String getId() {
    return this.id;
  }

  void setId(String id) {
    this.id = id;
  }

  String getTitle() {
    return this.title;
  }

  void setTitle(String title) {
    this.title = title;
  }

  List<Food> getFoodList() {
    return this.foodList;
  }

  void setFoodList(List<Food> foodList) {
    this.foodList = foodList;
  }

  String getImage() {
    return this.image;
  }

  void setImage(String image) {
    this.image = image;
  }

  bool getSelectedChoice() {
    return this.isSelected;
  }

  void setSelectedChoice(bool isSelected) {
    this.isSelected = isSelected;
  }

  Color setColor() {
    if(this.isSelected == true) {
      return Colors.red;
    }else {
      return Colors.white;
    }
  }

}