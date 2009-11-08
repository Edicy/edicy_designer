
<div id="langmenu">
{% if editmode %}
    <ul>
        {% for language in site.languages %}
             <li><a href="{{ language.url }}" {% if language.selected? %}class="active"{% endif %}>{{ language.title }}</a></li>
        {% endfor %}
        <li>{%languageadd%}</li>
    </ul>
{% else %}
    {% if site.has_many_languages? %}
        <ul>
            {% for language in site.languages %}
                 <li><a href="{{ language.url }}" {% if language.selected? %}class="active"{% endif %}>{{ language.title }}</a></li>
            {% endfor %}
        </ul>
    {% endif %}
{% endif %}
</div>
