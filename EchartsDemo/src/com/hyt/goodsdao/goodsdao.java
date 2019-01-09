package com.hyt.goodsdao;

import java.sql.SQLException;
import java.util.List;

import com.hyt.entity.Goods;

/**
 * 
 * */
public interface goodsdao {
	public List<Goods> queryAllGoods() throws SQLException;
}
