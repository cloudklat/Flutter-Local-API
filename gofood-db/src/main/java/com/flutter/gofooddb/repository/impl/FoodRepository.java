package com.flutter.gofooddb.repository.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.flutter.gofooddb.model.Food;
import com.flutter.gofooddb.repository.IFoodRepository;

@Repository
public class FoodRepository implements IFoodRepository {

    @Autowired
    JdbcTemplate jdbcTemplate;

    @Override
    public Food insertFood(Food food) {
        // TODO Auto-generated method stub
        String query = "INSERT INTO tb_produk(nama, harga, quantity) "
                + "VALUES(?, ?, ?)";
        jdbcTemplate.update(query,
                new Object[] { food.getNama(), food.getHarga(), food.getQuantity() });
        return food;
    }

    @Override
    public List<Food> getAllFood() {
        // TODO Auto-generated method stub
        String query = "SELECT * FROM tb_produk";
        return jdbcTemplate.query(query, new BeanPropertyRowMapper<>(Food.class));
    }

    @Override
    public Food updateFood(int id, Food food) {
        // TODO Auto-generated method stub
        String query = "UPDATE tb_produk SET nama = ?, harga = ?, quantity = ? where id = ?";
        jdbcTemplate.update(query, new Object[] { food.getNama(), food.getHarga(), food.getQuantity(), id });
        return food;
    }

    @Override
    public Food deleteFood(int id) {
        // TODO Auto-generated method stub
        String query = "SELECT * FROM tb_produk WHERE id = ?";
        var result = jdbcTemplate.queryForObject(query, new BeanPropertyRowMapper<>(Food.class), id);
        query = "DELETE FROM tb_produk WHERE id = ?";
        jdbcTemplate.update(query, id);
        return result;
    }

}
