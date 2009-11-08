<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN"
	"http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
<head>
{% include "SiteHeader" %}
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
        {% content %}
        
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
  {% unless editmode %}{{ site.analytics }}{% endunless %}
</body>
</html>

