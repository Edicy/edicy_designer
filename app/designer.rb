#!/usr/bin/env ruby

$:.unshift(File.expand_path(File.dirname(__FILE__)) + '/lib')
$:.unshift(File.expand_path(File.dirname(__FILE__)) + '/drops')

require 'rack'
require 'sinatra'
require 'action_view'
require 'liquid'
require 'cms/data'
require 'cms/drops'
require 'cms/liquid'

set :run, true
set :environment, :production
set :port, 9494
set :public, File.dirname(__FILE__) + '/public'
set :views, File.dirname(__FILE__) + '/views'

get '/admin' do
  erb :index
end

get %r{/(stylesheets|images|javascripts)/(.*)} do |directory, filename|
  send_file(File.join(design_path, directory, filename))
end

get '/*' do
  Data.load(datafile_path)
  
  page = Data.resolve_page(params[:splat].join('/'))
  
  raise Sinatra::NotFound if page.nil?

  assigns = {
    'site' => SiteDrop.new,
    'page' => PageDrop.new(page),
    'editmode' => Data.db.options.editmode,
    'site_path' => '/',
    'files_path' => '/files',
    'images_path' => '/images',
    'javascripts_path' => '/javascripts',
    'photos_path' => '/photos',
    'stylesheets_path' => '/stylesheets'
  }
  
  if page.content_type == 'blog'
    blog = BlogDrop.new(page)
    assigns.merge!({
      'blog' => blog,
      'articles' => blog.articles
    })
    
    if (params[:splat].first.split('/') - page.path.split('/')).size == 1
      article_path = (params[:splat].first.split('/') - page.path.split('/')).first
      article = Data.article(article_path)
      page.layout = article.layout
      assigns.merge!({
        'article' => ArticleDrop.new(article)
      })
    end
  end
  
  fs = CMS::Liquid::CmsFileSystem.new(design_path)
  Liquid::Template.file_system = fs
  code = fs.read_template_file(page.layout)
  
  tpl = Liquid::Template.parse(code)
  tpl.render!(assigns, :registers => {
    :relative_url_root => '/'
  })
end

not_found do
  @datafile = datafile_path
  erb :not_found
end

error do
  @message = request.env['sinatra.error'].message
  erb :error
end

private

def datafile
  (session[:datafile] || 'default')
end

def datafile_path
  File.expand_path(File.join(File.dirname(__FILE__), '..', 'sites', "#{datafile}.yml"))
end

def design
  (session[:design] || Data.db.options.design)
end

def design_path
  File.expand_path(File.join(File.dirname(__FILE__), '..', 'designs', design))
end

Thread.new do
  sleep(1)
  puts "Opening up browser..."
  
  case RUBY_PLATFORM 
  when /darwin/
    system("open http://localhost:9494/")
  when /win/
    system("start http://localhost:9494/")
  end
end
