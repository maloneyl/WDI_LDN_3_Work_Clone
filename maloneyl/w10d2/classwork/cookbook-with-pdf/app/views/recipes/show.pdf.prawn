require 'open-uri'

# prawn_document(force_download: true) do |pdf|
prawn_document do |pdf|

  pdf.text @recipe.name, size: 40, mode: :stroke

  pdf.move_down 100 # move 100 PDF points down (weird unit; 1 PDF Point = 1/72 of an inch; see http://prawn.majesticseacreature.com/manual.pdf)
  pdf.stroke_horizontal_rule

  pdf.move_down 5
  pdf.image URI.parse(@recipe.image).open, width: 400, position: :center # essentially URI.open; also in production we'll have a cache strategy instead of downloading the image every time

  pdf.move_down 5
  pdf.stroke_horizontal_rule

  pdf.move_down 5
  pdf.table([
    ["Course", @recipe.course],
    ["Cooktime", @recipe.cooktime],
    ["Serving Size", @recipe.servingsize]
  ], width: 300) # width of each row

  pdf.start_new_page

  pdf.text "Instructions:", size: 20
  pdf.text @recipe.instructions
  pdf.move_down 30

  pdf.text "Ingredients:", size: 20
  @recipe.ingredients.each do |ingredient|
    pdf.text ingredient.name
    pdf.image URI.parse(ingredient.image).open, width: 200
    pdf.stroke_horizontal_rule
    pdf.move_down 10
  end

  pdf.start_new_page

  pdf.rotate(-30, origin: [250, 200]) do # just to show you can rotate an image...
    pdf.image URI.parse(@recipe.image).open, width: 400
  end

  pdf.span(350, position: :center) do
    pdf.text "Bacon ipsum dolor sit amet short ribs ham hock swine spare ribs jerky. Shoulder turkey pork chop, bacon kevin spare ribs pork belly swine short ribs cow sirloin tail venison. Ham hock drumstick kielbasa brisket boudin bacon meatball. Drumstick ribeye venison, pastrami turducken tenderloin strip steak chuck kevin pig chicken tail beef ribs sirloin frankfurter. Frankfurter pork chop tail, andouille pig ground round rump pork belly corned beef filet mignon. Kevin strip steak tongue shankle capicola pancetta brisket meatball. Sausage ground round pastrami spare ribs. Short ribs pork bresaola swine, spare ribs ball tip rump."
  end

end
