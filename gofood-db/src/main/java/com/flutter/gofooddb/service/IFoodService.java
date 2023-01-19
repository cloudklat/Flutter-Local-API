package com.flutter.gofooddb.service;

import java.util.List;

import com.flutter.gofooddb.model.Food;

public interface IFoodService {
    public Food insertFood(Food food);
    public List<Food> getAllFood();
    public Food updateFood(int id, Food food);
    public Food deleteFood(int id);
}
