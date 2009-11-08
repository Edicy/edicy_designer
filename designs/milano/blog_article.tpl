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
              
       <div class="blog">
         <div class="blog-date"><span>{{ article.created_at | date:"%d" }}</span><br />{{ article.created_at | date:"%b" }}</div>
         <div class="blog-inner">
           <h1>{% editable article.title plain="true" %}</h1>
   
           <div class="blog-content">
             {% editable article.excerpt %}
             <div id="articlebody">
               {% editable article.body %}
             </div> 
           </div> <!-- //blog-content -->
               
           <div class="blog-information">
             {{ article.author.name }} | {{"comments_for_count"|lc}}: {{ article.comments_count }}
           </div> <!-- //blog-information -->
         </div> <!-- blog-inner -->
       </div> <!-- //blog -->

         <div class="comments"><a name="comments"></a>
         {% unless article.new_record? %}<h1>{{"comments"|lc}}</h1>{% endunless %}
         {% for comment in article.comments %}
         
         <div class="comment">
           <div class="comment-count">{{ forloop.index }}</div>
           <div class="comment-inner">
             {{ comment.body }}

             <div class="comment-information">
               {{ comment.author }}, {{ comment.created_at | date:"%d. %B %Y" }}
             </div> <!-- //comment-information -->
           </div> <!-- comment-inner -->
         </div> <!-- //comment -->
         
         {% endfor %}
         
         
         {% unless article.new_record? %}<h1>{{"add_a_comment"|lc}}</h1>{% endunless %}
         
         {% commentform %}
{% unless comment.valid? %}<ul>
{% for error in comment.errors %}
<li>{{ error | lc }}</li>
{% endfor %}
</ul>{% endunless %}
           <table>
             <tr>
               <td class="first">{{"name"|lc}}</td>
               <td><input type="text" name="comment[author]" class="textbox" value="{{comment.author}}" /></td>
             </tr>
             <tr>
               <td class="first">{{"email"|lc}}</td>
               <td><input type="text" name="comment[author_email]" class="textbox" value="{{comment.author_email}}" /></td>
             </tr>
             <tr>
               <td class="first">{{"comment"|lc}}</td>
               <td><textarea cols="30" rows="5" name="comment[body]" class="textbox">{{comment.body}}</textarea></td>
             </tr>
             <tr>
               <td colspan="2" class="first"><input type="submit" class="submit" value="{{"submit"|lc}}" /></td>
             </tr>
           </table>
         {% endcommentform %}
         
       </div> <!-- //comments -->
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