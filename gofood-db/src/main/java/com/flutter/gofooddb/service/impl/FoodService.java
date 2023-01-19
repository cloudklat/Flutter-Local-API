package com.flutter.gofooddb.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.flutter.gofooddb.model.Food;
import com.flutter.gofooddb.repository.IFoodRepository;
import com.flutter.gofooddb.service.IFoodService;

@Service
public class FoodService implements IFoodService {

    @Autowired
    IFoodRepository foodRepository;

    @Override
    public Food insertFood(Food food) {
        // TODO Auto-generated method stub
        return foodRepository.insertFood(food);
    }

    @Override
    public List<Food> getAllFood() {
        // TODO Auto-generated method stub
        return foodRepository.getAllFood();
    }

    @Override
    public Food updateFood(int id, Food food) {
        // TODO Auto-generated method stub
        return foodRepository.updateFood(id, food);
    }

    @Override
    public Food deleteFood(int id) {
        // TODO Auto-generated method stub
        return foodRepository.deleteFood(id);
    }
}
