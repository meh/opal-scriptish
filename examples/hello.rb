# ---
# name: opal-scriptish hello world
# namespace: http://github.com/meh/opal-scriptish
# description: a simple scriptish script written in Ruby
# include: *
# ---
# keep in mind that this header is REQUIRED, or it won't be recognized as an opal-scriptish
# script and you'll become a sad panda

Document.ready do
  alert "You're on #{Document.title} :3"
end
