# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

home = Page.find_or_create_by!(slug: "home") do |page|
  page.title = "Home"
  page.status = "published"
end

home.page_sections.find_or_create_by!(section_key: "hero_title") do |section|
  section.title = "Hero Title"
  section.content = "Welcome to DOUTS"
  section.position = 1
  section.visible = true
end

home.page_sections.find_or_create_by!(section_key: "hero_intro") do |section|
  section.title = "Hero Intro"
  section.content = "DOUTS is a university dive club for people who love diving, marine life, underwater photography, and getting out on the water."
  section.position = 2
  section.visible = true
end

home.page_sections.find_or_create_by!(section_key: "join_cta") do |section|
  section.title = "Join Call to Action"
  section.content = "Become a member and join our dives, trips, training, and social events."
  section.button_text = "Join DOUTS"
  section.button_url = "/register"
  section.position = 3
  section.visible = true
end

about = NavItem.find_or_create_by!(title: "About", parent_id: nil) do |item|
  item.url = "/about"
  item.position = 1
  item.visible = true
end

NavItem.find_or_create_by!(title: "Committee", parent: about) do |item|
  item.url = "/committee"
  item.position = 1
  item.visible = true
end

NavItem.find_or_create_by!(title: "Documents", parent: about) do |item|
  item.url = "/documents"
  item.position = 2
  item.visible = true
end

learn = NavItem.find_or_create_by!(title: "Learn to Dive", parent_id: nil) do |item|
  item.url = "/learn-to-dive"
  item.position = 2
  item.visible = true
end

NavItem.find_or_create_by!(title: "Courses", parent: learn) do |item|
  item.url = "/courses"
  item.position = 1
  item.visible = true
end

NavItem.find_or_create_by!(title: "FAQs", parent: learn) do |item|
  item.url = "/faqs"
  item.position = 2
  item.visible = true
end

NavItem.find_or_create_by!(title: "Events", parent_id: nil) do |item|
  item.url = "/events"
  item.position = 3
  item.visible = true
end

NavItem.find_or_create_by!(title: "Membership", parent_id: nil) do |item|
  item.url = "/membership"
  item.position = 4
  item.visible = true
end