package controller;

import model.Article;
import util.GlobalConfigHelper;
import util.URLHelper;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;
import java.util.Properties;

public class HomeController extends HttpServlet {
    private Properties properties = null;
    public static int perPageArticles = 10;

    @Override
    public void init() {
        properties = GlobalConfigHelper.getConfigFromContext(this.getServletContext());
    }

    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response
    ) throws ServletException, IOException {
        Article article = new Article(properties);
        int uid = (int)request.getSession().getAttribute("uid");
        List<Article> articles = article.getArticlesByUserId(uid,1, perPageArticles);
        request.setAttribute("articles", articles);
        RequestDispatcher dispatcher = getServletContext().getRequestDispatcher(
                properties.getProperty("TemplatePathRoot") + "/user/home.jsp");
        dispatcher.forward(request, response);
    }

    @Override
    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response
    ) throws ServletException, IOException {
        int uid = Integer.parseInt(URLHelper.getRouterParam(request.getRequestURI(), 2));
        String subrouter = URLHelper.getRouterParam(request.getRequestURI(), 3);
        if (subrouter.equals(""))
            response.sendRedirect("/user/" + uid);
        else {
            switch (subrouter) {
                case "article":
                    request.getRequestDispatcher("/article").forward(request, response);
            }
        }
    }
}
