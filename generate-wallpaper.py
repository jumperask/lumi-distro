#!/usr/bin/env python3
"""
Générateur de wallpaper pour LumiDistro
Crée un fond d'écran moderne et épuré avec dégradé
"""

from PIL import Image, ImageDraw, ImageFont
import os

def create_wallpaper(width=1920, height=1080, output_path="wallpaper.png"):
    """Crée un wallpaper moderne avec dégradé"""
    
    # Créer l'image
    img = Image.new('RGB', (width, height))
    draw = ImageDraw.Draw(img)
    
    # Couleurs du dégradé (thème sombre LumiDistro)
    color_top = (30, 30, 46)    # #1e1e2e
    color_mid = (24, 24, 37)    # #181825
    color_bottom = (17, 17, 27) # #11111b
    
    # Créer le dégradé vertical
    for y in range(height):
        # Calculer la position dans le dégradé (0 à 1)
        ratio = y / height
        
        if ratio < 0.5:
            # Partie supérieure
            local_ratio = ratio * 2
            r = int(color_top[0] + (color_mid[0] - color_top[0]) * local_ratio)
            g = int(color_top[1] + (color_mid[1] - color_top[1]) * local_ratio)
            b = int(color_top[2] + (color_mid[2] - color_top[2]) * local_ratio)
        else:
            # Partie inférieure
            local_ratio = (ratio - 0.5) * 2
            r = int(color_mid[0] + (color_bottom[0] - color_mid[0]) * local_ratio)
            g = int(color_mid[1] + (color_bottom[1] - color_mid[1]) * local_ratio)
            b = int(color_mid[2] + (color_bottom[2] - color_mid[2]) * local_ratio)
        
        draw.line([(0, y), (width, y)], fill=(r, g, b))
    
    # Ajouter des cercles décoratifs subtils
    # Cercle bleu en haut à gauche
    draw.ellipse([100, 100, 300, 300], outline=(137, 180, 250, 30), width=2)
    draw.ellipse([150, 150, 250, 250], outline=(137, 180, 250, 20), width=1)
    
    # Cercle rose en bas à droite
    draw.ellipse([width-300, height-300, width-100, height-100], outline=(243, 139, 168, 30), width=2)
    draw.ellipse([width-250, height-250, width-150, height-150], outline=(243, 139, 168, 20), width=1)
    
    # Ajouter le logo/texte "LumiDistro"
    try:
        # Essayer d'utiliser une police système
        font = ImageFont.truetype("/usr/share/fonts/truetype/dejavu/DejaVuSans-Bold.ttf", 48)
    except:
        font = ImageFont.load_default()
    
    text = "LumiDistro"
    # Calculer la position du texte (centré)
    bbox = draw.textbbox((0, 0), text, font=font)
    text_width = bbox[2] - bbox[0]
    text_height = bbox[3] - bbox[1]
    
    x = (width - text_width) // 2
    y = (height - text_height) // 2
    
    # Ajouter le texte avec une ombre subtile
    draw.text((x + 2, y + 2), text, fill=(0, 0, 0, 100), font=font)
    draw.text((x, y), text, fill=(137, 180, 250), font=font)
    
    # Sauvegarder l'image
    img.save(output_path, "PNG")
    print(f"Wallpaper créé: {output_path}")

if __name__ == "__main__":
    # Créer le wallpaper dans le répertoire de configuration
    output_dir = "files/home/.config"
    os.makedirs(output_dir, exist_ok=True)
    
    create_wallpaper(1920, 1080, f"{output_dir}/wallpaper.png")
    create_wallpaper(2560, 1440, f"{output_dir}/wallpaper-2k.png")
