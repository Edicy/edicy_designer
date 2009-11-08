{% for article in site.latest_articles limit:1 %}
<div id="sidebar-top">
               {{"latest_news"|lc}}
       </div> <!-- //sidebar-top -->
       
       <div class="sidebar-inner">
         <table class="news">
                  {% for article in site.latest_articles %}
                  {% if forloop.index < 5 %}
                  <tr>
                    <td class="first">{{ article.created_at | date:"%d.%m" }}</td>
                    <td><a href="{{ article.url }}">{{ article.title }}</a></td>
                  </tr>
                  {% endif %}
                  {% endfor %}
         
          </table>
        </div> <!-- //sidebar-inner -->
           {% endfor %}