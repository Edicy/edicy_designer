<ul id="mainmenu">
  <li><a href="{{ site.root_item.url }}"{% if site.root_item.current? %} class="active"{% endif %}>{{site.root_item.title}}</a></li>
{% for item in site.all_menuitems %}
<li><a href="{{ item.url }}"{% unless item.translated? %} class="untranslated fci-editor-menuadd"{% endunless %}{% if item.selected? %} class="active"{% endif %}>{{ item.title }}</a></li>
{% endfor %}
{% if editmode %}<li>{% menuadd %}</li>{% endif %}
</ul>

{% for item in site.all_menuitems %}{% if item.selected? %}
{% if editmode %}
<ul id="submenu">
{% for level2 in item.all_children %}
<li><a href="{{ level2.url }}"{% unless level2.translated? %} class="untranslated fci-editor-menuadd"{% endunless %}{% if level2.selected? %} class="active"{% endif %}>{{ level2.title }}</a></li>
{% endfor %}
<li>{% menuadd parent="item" %}</li>
</ul>
{% else %}
{% if item.children? %}
<ul id="submenu">
{% for level2 in item.children %}
<li><a href="{{ level2.url }}"{% if level2.selected? %} class="active"{% endif %}>{{ level2.title }}</a></li>
{% endfor %}
</ul>
{% endif %}
{% endif %}
{% endif %}{% endfor %}
