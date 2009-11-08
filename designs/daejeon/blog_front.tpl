<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN"
	"http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
<head>
{% include "SiteHeader" %}
  {{ blog.rss_link }}
</head>

<body>
  <div id="container">
    {% include "Langmenu" %}
    <div class="clearer"></div>

    <div id="header">
      <div id="logo">{% editable site.header %}</div>
      {% include "Mainmenu" %}
    </div>
    <div class="clearer"></div>
    <div id="body">
      <div id="left_column" class="box_700">
   {% for article in articles %}
        <h2><a href="{{article.url}}">{{article.title}}</a> <span class="blog_date">{{ article.created_at | date:"%b %d" }}</span></h2>

        
        <span class="news_actions">{{article.author.name}} · <strong><a href="{{article.url}}#comments">{{ "comments_for_count" | lc }}: {{article.comments_count}}</a></strong></span>
        
        <p>{{article.excerpt}}</p>
        <a href="{{article.url}}" class="readmore">{{"read_more"|lc}} &raquo;</a>
        <div class="blogspacing"></div>
	{% endfor %}
      </div>

      <div id="right_column" class="box_200">
        {% include "Submenu" %}
        
        {% if site.search.enabled %}{% include "Search" %}{% endif %}
      </div>
    </div>
    <div class="clearer"></div>
    <div id="footer">
       <div class="footer_content">{% xcontent name="footer" %}</div>
       <div id="edicy">{% loginblock %}{{ "footer_login_link" | lc }}{% endloginblock %}</div>

    </div>
    <div class="clearer"></div>
  </div>
  {% unless editmode %}{{site.analytics}}{% endunless %}
</body>
</html>

