"""_summary_ Este archivo implementa interpolación bilineal de imágenes
    Implementado por Jason Leitón Jiménez para guía de prueba del proyecto 2
    Returns:
        _type_: _description_
"""
import numpy as np
from PIL import Image

def bilinear_interpolation(image, new_width, new_height):
    old_width, old_height = image.size
    new_image = Image.new("L", (new_width, new_height))  
    pixels = np.array(image.convert("L"))  

    for y in range(new_height):
        for x in range(new_width):
            
            x_old = x * (old_width / new_width)
            y_old = y * (old_height / new_height)

            x1 = int(x_old)
            x2 = min(x1 + 1, old_width - 1)
            y1 = int(y_old)
            y2 = min(y1 + 1, old_height - 1)

            
            dx = x_old - x1
            dy = y_old - y1

            
            for c in range(1):  
                top = (1 - dx) * pixels[y1, x1] + dx * pixels[y1, x2]
                bottom = (1 - dx) * pixels[y2, x1] + dx * pixels[y2, x2]
                new_pixel = int((1 - dy) * top + dy * bottom)
                new_image.putpixel((x, y), new_pixel)

    return new_image

def get_quadrant(image, quadrant):
    width, height = image.size
    quad_width = width // 4
    quad_height = height // 4
    x_offset = (quadrant % 4) * quad_width
    y_offset = (quadrant // 4) * quad_height
    box = (x_offset, y_offset, x_offset + quad_width, y_offset + quad_height)
    return image.crop(box), (quad_width, quad_height)


input_image = Image.open("escudo.jpg")  # Cambie el nombre por la imagen de entrada
width, height = input_image.size
quadrant = int(input("Selecciona el cuadrante (0-15): "))


selected_quadrant, (quad_width, quad_height) = get_quadrant(input_image, quadrant)


gray_image = input_image.convert("L")


with open("pixels.txt", "w") as f:
    f.write(f"{height} {width}\n")  
    pixels = np.array(gray_image)
    for row in pixels:
        for pixel in row:
            f.write(f"{pixel}\n")  


new_width = 400  
new_height = 400  


resized_quadrant = bilinear_interpolation(selected_quadrant.convert("L"), new_width, new_height)


resized_quadrant.save("output_image.jpg")  

print("Interpolación bilineal completada, el cuadrante guardado como 'output_image.jpg' y los píxeles almacenados en 'pixels.txt'.")