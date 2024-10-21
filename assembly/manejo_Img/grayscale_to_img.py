from PIL import Image

def grayscale_string_to_image(input_file, width, height, output_image_path):
    # Crear una lista para almacenar los valores de los píxeles
    pixels = []

    # Leer el archivo de entrada y convertir los valores hexadecimales a escala de grises
    with open(input_file, "r") as file:
        for line in file:
            # Convertir el valor hexadecimal a un entero
            pixel_value = int(line.strip(), 16)
            pixels.append(pixel_value)

    # Verificar si el número de píxeles coincide con el tamaño de la imagen
    if len(pixels) != width * height:
        raise ValueError("El número de píxeles en el archivo no coincide con las dimensiones de la imagen.")

    # Crear una nueva imagen en modo 'L' (escala de grises)
    img = Image.new("L", (width, height))

    # Colocar los valores de los píxeles en la imagen
    img.putdata(pixels)

    # Guardar la imagen en la ruta especificada
    img.save(output_image_path)
    print(f"La imagen ha sido guardada en {output_image_path}")

# Uso del script
input_file = "imagen_completa_greyscale.txt"  # Reemplaza con la ruta de tu archivo de entrada
width, height = 400, 400  # Reemplaza con las dimensiones de la imagen
output_image_path = "restored_image.png"
grayscale_string_to_image(input_file, width, height, output_image_path)
