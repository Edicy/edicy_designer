<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">

<head>
{% include "SiteHeader" %}
{{ blog.rss_link }}
</head>

<body>
	
	<div id="wrap">
   
          {% include "Langmenu" %}
          {% include "Mainmenu" %}

   <div id="header">
     <table id="header-table">
       <tr>
         <td class="title">{% if editmode %}{% editable site.header %}{%else%}<a href="{{ site.root_item.url }}">{% editable site.header %}</a>{% endif %}</td>
       </tr>
     </table> 
   </div><!-- //header -->
   
   <div id="container">
     
     <div id="content">
              <div id="content-inner">

       {% for article in articles %}
       <div class="blog">
         <div class="blog-date"><span>{{ article.created_at | date:"%d" }}</span><br />{{ article.created_at | date:"%b" }}</div>
         <div class="blog-inner">
           <h1><a href="{{ article.url }}">{{ article.title }}</a></h1>
   
           <div class="blog-content">
             {{ article.excerpt }} <a href="{{ article.url }}">{{"read_more"|lc}}</a>
           </div> <!-- //blog-content -->
               
           <div class="blog-information">
             {{ article.author.name }} | <a href="{{ article.url }}#comments">{{"comments_for_count"|lc}}: {{ article.comments_count }}</a>
           </div> <!-- //blog-information -->
         </div> <!-- blog-inner -->
       </div> <!-- //blog -->
{% endfor %}
            </div>
     </div> <!-- //content -->
     
     <div id="sidebar">
       {% include "News" %}
        
        
        
              {% include "Sidebar" %}

             
        
        <div id="edicy">
          {% loginblock %}{{ "footer_login_link" | lc }}{% endloginblock %}
        </div> <!-- //edicy -->
        
        
         
     </div> <!-- //sidebar -->
     
     <div class="clearer"></div>
     
   </div> <!-- //container -->
    
  </div> <!-- //wrap -->
{% unless editmode %}{{ site.analytics }}{% endunless %}
</body>
</html>