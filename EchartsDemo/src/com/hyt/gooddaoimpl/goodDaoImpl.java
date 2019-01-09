package com.hyt.gooddaoimpl;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.hyt.entity.Goods;
import com.hyt.goodsdao.goodsdao;
import com.hyt.util.Conn;

public class goodDaoImpl implements goodsdao{

	@Override
	public List<Goods> queryAllGoods() throws SQLException {
		Connection conn = null;
		List<Goods> list = new ArrayList(); 
		try {
			conn = Conn.getConn();
			String sql = "select * from goods";
			PreparedStatement ps = conn.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
			while(rs.next()) {
				Goods good = new Goods();
				good.setId(rs.getInt(1));
				good.setName(rs.getString(2));
				good.setSum(rs.getInt(3));
				list.add(good);	
			}
			
		} catch (IOException e) {
			e.printStackTrace();
		}
		Conn.colseConn(conn);
		return list;
	}
//  测试代码	
//	public static void main(String[] args) {
//		goodDaoImpl gd = new goodDaoImpl();
//		try {
//			List<Goods> list = gd.queryAllGoods();
//			for(Goods g : list) {
//				System.out.println(g);
//			}
//		} catch (SQLException e) {
//			// TODO Auto-generated catch block
//			e.printStackTrace();
//		}
//	}
}
