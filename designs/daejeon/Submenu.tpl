{% if editmode %}
{% for item in site.menuitems %}
{% if item.selected? %}

<ul id="submenu">
{% for level2 in item.all_children %}
          <li{% unless level2.translated? %} class="untranslated"{% endunless %}><a href="{{level2.url}}"{% unless level2.translated? %} class="fci-editor-menuadd"{% endunless %}{% if level2.selected? %} class="active"{% endif %}>{{level2.title}}</a></li>
{% endfor %}
<li>{% menuadd parent="item" %}</li>
        </ul>

{% endif %}
{% endfor %}
{% else %}
            {% for item in site.menuitems %}
{% if item.selected_with_children? %}
<ul id="submenu">
{% for level2 in item.all_children %}
          <li><a href="{{level2.url}}"{% if level2.selected? %} class="active"{% endif %}>{{level2.title}}</a></li>
{% endfor %}
</ul>
{% endif %}
            {% endfor %}
{% endif %}
