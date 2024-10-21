from PIL import Image

def image_to_grayscale_string(image_path, output_file):
    # Open the image and convert to grayscale
    img = Image.open(image_path).convert("L")
    # Resize to 400x400 if it's not already
    img = img.resize((400, 400))

    with open(output_file, "w") as file:
        # Iterate through each pixel and get the grayscale value
        for y in range(400):
            for x in range(400):
                # Get the pixel value and convert to hexadecimal
                pixel_value = img.getpixel((x, y))
                hex_value = f"{pixel_value:02X}"
                # Write to the output file
                file.write(f"{hex_value}\n")

    print(f"Grayscale values have been written to {output_file}")

# Example usage
image_path = "prueba1.jpg"  # Replace with your image path
output_file = "output_grayscale1.txt"
image_to_grayscale_string(image_path, output_file)
