	<title>{{ site.name }} &gt; {{ page.title }}</title>
	<meta name="keywords" content="{{ page.keywords }}" />
	<meta name="description" content="{{ page.description }}" />
        <meta name="copyright" content="{{ site.copyright }}" />
	<meta name="author" content="{{ site.author }}" />
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	{% stylesheet_link "style.css?daejeon" %}
	{% if editmode %}{% stylesheet_link "assets/admin/editmode.css" static_host="true" %}{% endif %}
        <link rel="icon" href="/favicon.ico" type="image/x-icon" />
	<link rel="shortcut icon" href="/favicon.ico" type="image/ico" />
	<link rel="shortcut icon" href="/favicon.ico" type="image/x-icon" />
{% if site.search.enabled %}
	{% stylesheet_link "assets/site_search/1.0/site_search.css" static_host="true" %}
	<script type="text/javascript" src="http://www.google.com/jsapi"></script>
	<script type="text/javascript" src="http://static.edicy.com/assets/site_search/1.0/site_search.min.js"></script>
	<script type="text/javascript" charset="utf-8">
  var search_translations = {"search": "{{ "search"|lc }}", "close": "{{ "search_close"|lc }}", "noresults": "{{ "search_noresults"|lc }}"};
	</script>
        {% endif %}
<!--[if IE 6]>
<style type="text/css">
#logo {
width: 200px;
}
</style>
<![endif]-->
<!--[if lte IE 7]>
<style type="text/css">
#mainmenu .untranslated {
position: relative;
top: 5px;
}
</style>
<![endif]-->
