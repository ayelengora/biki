

# lib/commands/draw_triangle.rb
module Commands
  class DrawTriangle
    def run(bitmap, x, y, height, colour)
      return puts "There is no image" if bitmap.nil?

      @bitmap = bitmap
      @x = x.to_i
      @y = y.to_i
      @height = height.to_i
      @colour = colour

      if invalid_coordinates?
        puts "Triangle exceeds image boundaries"
      elsif !@bitmap.valid_colour?(@colour)
        puts "Invalid colour: #{@colour}. Only single uppercase characters are allowed"
      else
        draw_triangle
      end
    end

    private

    def draw_triangle
      # Dibuja los lados del triángulo
      (0...@height).each do |i|
        @bitmap.draw_pixel(@x - i, @y + i, @colour) # Lado izquierdo
        @bitmap.draw_pixel(@x + i, @y + i, @colour) # Lado derecho
      end
      # Dibuja la base del triángulo
      ((@x - @height + 1)..(@x + @height - 1)).each do |col|
        @bitmap.draw_pixel(col, @y + @height - 1, @colour)
      end
    end

    def invalid_coordinates?
      !@bitmap.valid_coordinates?(@x, @y) ||
        !@bitmap.valid_coordinates?(@x, @y + @height - 1)
    end
  end
end

# spec/commands/draw_triangle_spec.rb
require "spec_helper"
require_relative "../../lib/commands/draw_triangle"
require_relative "../../lib/bitmap"

RSpec.describe Commands::DrawTriangle do
  let(:bitmap) { Bitmap.new(10, 10) }
  let(:draw_triangle) { Commands::DrawTriangle.new }

  context "when drawing a valid triangle" do
    it "draws a triangle on the bitmap" do
      draw_triangle.run(bitmap, 5, 2, 4, "T")

      expected_output = [
        "OOOOOOOOOO",
        "OOOOOOOOOO",
        "OOOOOOTOOO",
        "OOOOOTOTOO",
        "OOOOTTTTOO",
        "OOOTTTTTOO",
        "OOOOOOOOOO",
        "OOOOOOOOOO",
        "OOOOOOOOOO",
        "OOOOOOOOOO"
      ].join("\n")

      expect(bitmap.to_s).to eq(expected_output)
    end
  end

  context "when the triangle is out of bounds" do
    it "does not draw and prints an error message" do
      expect { draw_triangle.run(bitmap, 8, 8, 4, "T") }.to output(/Triangle exceeds image boundaries/).to_stdout
    end
  end

  context "when the color is invalid" do
    it "does not draw and prints an error message" do
      expect { draw_triangle.run(bitmap, 5, 2, 4, "red") }.to output(/Invalid colour/).to_stdout
    end
  end

  context "when there is no bitmap" do
    it "prints an error message" do
      expect { draw_triangle.run(nil, 5, 2, 4, "T") }.to output(/There is no image/).to_stdout
    end
  end
end

# lib/commands/save_image.rb
module Commands
  class SaveImage
    def run(bitmap, filename)
      return puts "There is no image" if bitmap.nil?
      return puts "Invalid filename" if filename.nil? || filename.strip.empty?

      File.open(filename, "w") { |file| file.write(bitmap.to_s) }
      puts "Image saved as #{filename}"
    end
  end
end

# spec/commands/save_image_spec.rb
require "spec_helper"
require_relative "../../lib/commands/save_image"
require_relative "../../lib/bitmap"

RSpec.describe Commands::SaveImage do
  let(:bitmap) { Bitmap.new(5, 5) }
  let(:save_image) { Commands::SaveImage.new }
  let(:filename) { "test_output.txt" }

  context "when saving a valid bitmap" do
    it "saves the bitmap to a file" do
      expect(File).to receive(:open).with(filename, "w")
      save_image.run(bitmap, filename)
    end
  end

  context "when there is no bitmap" do
    it "prints an error message" do
      expect { save_image.run(nil, filename) }.to output(/There is no image/).to_stdout
    end
  end

  context "when filename is invalid" do
    it "prints an error message for nil filename" do
      expect { save_image.run(bitmap, nil) }.to output(/Invalid filename/).to_stdout
    end

    it "prints an error message for empty filename" do
      expect { save_image.run(bitmap, " ") }.to output(/Invalid filename/).to_stdout
    end
  end
end
