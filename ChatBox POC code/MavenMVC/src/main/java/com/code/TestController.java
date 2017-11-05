package com.code;

import java.net.UnknownHostException;
import java.util.Date;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.bind.annotation.SessionAttributes;

import com.mongodb.BasicDBObject;
import com.mongodb.DB;
import com.mongodb.DBCollection;
import com.mongodb.DBCursor;
import com.mongodb.DBObject;
import com.mongodb.MongoClient;

@Controller
@SessionAttributes("greeting")
public class TestController {

	
	@RequestMapping("/login")
	public String getLoginPage(){		
		return "login";
	}
	
	@RequestMapping(value="/loginAction", method = RequestMethod.POST)
	public String doLogin(@RequestParam("uname") String uname, @RequestParam("pwd") String pwd, Model model, HttpServletResponse response){
		
		
		MongoClient client = new MongoClient("localhost",27017);
		DB db = client.getDB("ADMIN_DB");
		DBCollection coll = db.getCollection("admin_data");	
		DBCursor cursor = coll.find();
		response.addCookie(new Cookie("ucookie", uname));
		//user = uname;
		//System.out.println(cursor.hasNext());
		while(cursor.hasNext()){	
			DBObject obj = cursor.next();
			System.out.println(obj.get("uname")+"  "+obj.get("pwd"));
			if(uname.equals(obj.get("uname")) && pwd.equals(obj.get("pwd"))){
				model.addAttribute("greeting",uname);
				return "home-page";
			}
		}

		client.close();
		return "login-failed";
	}
	
	
	@RequestMapping("/hello")
	public String getPage(ModelMap model){		
		model.addAttribute("message","hello code");
		return "success";
	}
	
	@RequestMapping("/logout")
	public String getLogout(ModelMap model){		
		model.addAttribute("greeting","");
		return "login";
	}
	
	@RequestMapping("/sendGET")
	public String sendGet(){
		return "home-page";
	}
	
	@RequestMapping("/test")
	public String testGet(){
		return "chat-table";
	}
	
	@RequestMapping("/register")
	public String registerPage(){
		return "registration-page";
	}
	
	@RequestMapping("/getTable")
	public String getTable(){
		return "chat-table";
	}
	
	
	@RequestMapping(value="/doRegister", method = RequestMethod.POST)
	public String doRegister(@RequestParam("uname") String uname, @RequestParam("pwd") String pwd) throws UnknownHostException{
		MongoClient client = new MongoClient("localhost",27017);
		DB db = client.getDB("ADMIN_DB");
		DBCollection coll = db.getCollection("admin_data");		
		BasicDBObject document = new BasicDBObject();
		document.put("uname", uname);
		document.put("pwd", pwd);
		coll.insert(document);
		client.close();
		return "login";
	}

	
	@RequestMapping(value="/send", method = RequestMethod.POST)
	public String sendMessage(@RequestParam("msgBox") String chat, HttpServletRequest req) throws UnknownHostException{
		MongoClient client = new MongoClient("localhost",27017);
		DB db = client.getDB("CHAT");
		DBCollection coll = db.getCollection("msg");		
		BasicDBObject document = new BasicDBObject();
		
		Cookie[] cookies = req.getCookies();

		if (cookies != null) {
		 for (Cookie cookie : cookies) {
		   if (cookie.getName().equals("ucookie")) {		
				//System.out.println("****"+cookie.getValue());
				document.put("sender", cookie.getValue());
		    }
		  }
		}


		document.put("message", chat);
	    Date date = new Date();
        // display time and date
	    String time = String.format("%tc", date );
		document.put("time", time);
		DBCursor cursor = coll.find();
		System.out.println(cursor);
		coll.insert(document);
		/*DBCursor cursor = coll.find();
		System.out.println(cursor.hasNext());
		while(cursor.hasNext()){
			DBObject obj = cursor.next();
			System.out.println("message ::"+obj.get("message"));
		}
		*/
		client.close();
		return "redirect:/sendGET";
	}

}
