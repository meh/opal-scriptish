# ---
# name: opal-scriptish hello world
# namespace: http://github.com/meh/opal-scriptish
# description: a simple scriptish script written in Ruby
# include: *
# ---
# keep in mind that this header is REQUIRED, or it won't be recognized as an opal-scriptish
# script and you'll become a sad panda

def alert (text)
  `alert(text)`
end

def title
  `document.title`
end

alert "You're on #{title} :3"
