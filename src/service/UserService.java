package service;

import java.sql.ResultSet;
import java.util.*;

import dao.DBConnection;

public class UserService {
	DBConnection db=new DBConnection();
	//添加
	public int insert(String[] params) {
		String sql="insert into user(name,password,sex,age,address) values(?,?,?,?,?)";
		db.doSQL(sql,params);
		int i=db.getUpCount();
		db.getClose();
		return i;
	}
	//修改
	public int update(String[] params) {
		String sql="update user set name=?,password=?,sex=?,age=?,address=? where id=?";
		db.doSQL(sql,params);
		int i=db.getUpCount();
		db.getClose();
		return i;
	}
	//删除
	public int delete(String[] params) {
		String sql="delete from  user where id=?";
		db.doSQL(sql,params);
		int i=db.getUpCount();
		db.getClose();
		return i;
	}
	
	//查询
	public List<Map<String, String>> select(String sql, String[] params) throws Exception {
		
		db.doSQL(sql,params);
		ResultSet rs=db.getRS();
		List<Map<String, String>> list = null;
		if (rs != null) {
			rs.last();
			int rowNum = rs.getRow();
			if (rowNum > 0) {
				list = new ArrayList<Map<String,String>>();
				rs.beforeFirst();
				while (rs.next()) {
					Map<String, String> map = new HashMap<String, String>();
					map.put("id", rs.getString("id"));
					map.put("name", rs.getString("name"));
					map.put("password", rs.getString("password"));
					map.put("sex", rs.getString("sex"));
					map.put("age", rs.getString("age"));
					map.put("address", rs.getString("address"));
					list.add(map);
				}
			}
		} else {
			System.out.println("Search Error...");
		}
		db.getClose();
		return list;
	}
}
