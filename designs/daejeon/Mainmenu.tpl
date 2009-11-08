<ul id="mainmenu">
  <li{% if site.root_item.selected? %} class="active"{% endif %}><a href="{{site.root_item.url}}">{{site.root_item.title}}</a></li>
{% for item in site.all_menuitems %}
  <li{% unless item.translated? %} class="untranslated"{% endunless %}{% if item.selected? %} class="active"{% endif %}><a href="{{item.url}}"{% unless item.translated? %} class="fci-editor-menuadd"{% endunless %}>{{ item.title }}</a></li>
          {% if item.blog? %}{% assign bloglink = item.url %}{% endif %} 
{% endfor %}

{% if editmode %}        <li>{% menuadd %}</li>{% endif %}
      </ul>

          