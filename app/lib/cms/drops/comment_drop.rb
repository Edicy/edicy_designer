# = Availability of comments
#
# Comments can be accessed through article by using <tt>{{ article.comments }}</tt> variable. This accessor method returns only comments that are in public state (e.g. not spam). Here is an simple example:
#
#   {% for comment in article.comments %}
#   From: {{ comment.author }} at {{ comment.created_at | date:"%d.%m" }}<br/>
#   {{ comment.body }}
#   {% endfor %}
#   
class CommentDrop < Liquid::Drop
  
  def initialize(comment, blank_record = false)
    @comment = comment
  end
  
  # Returns author name for comment.
  def author
    @comment.author
  end
  
  # Returns formatted body for comment.
  def body
    @comment.body
  end
  
  def author_email
    @comment.author_email
  end
  
  # Returns Time object representing comment create time.
  def created_at
    @comment.created_at
  end
  
  # Returns list of errors associated with this comment
  def errors
    # e = Array.new
    # e << 'comment_author_blank' if author.blank?
    # e << 'comment_email_blank' if author_email.blank?
    # e << 'comment_body_blank' if body.blank?
    # e
  end
  
  # Check if comment has any errors
  def valid?
    true
  end
end