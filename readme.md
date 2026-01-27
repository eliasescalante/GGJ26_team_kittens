# 🎭 Project Kittens (Prototype)

Este repositorio contiene el prototipo funcional para la **Global Game Jam**, basado en la temática de **"Máscara"**. Es un sistema base escalable desarrollado en **Godot 4.5.1** que implementa las mecánicas core de un dodge 'em up lateral.

> [!IMPORTANT]
> **Nota del Prototipo:** Actualmente el proyecto utiliza *placeholders* visuales. El enfoque principal de esta versión es la lógica de movimiento 2.5D y el sistema dinámico de spawning.

## 🕹️ Mecánicas Implementadas

* [cite_start]**Sistema de Movimiento**: Control del jugador en ejes X/Y con físicas de deslizamiento para simular profundidad[cite: 5].
* [cite_start]**Spawning Inteligente**: Generador de enemigos que instancia diferentes tipos de amenazas por delante del jugador basándose en su posición global[cite: 5].
* [cite_start]**Gestión de Amenazas**: Sistema de daño por contacto (Hitbox/Hurtbox) donde los enemigos afectan la salud sin obstruir el movimiento físico[cite: 3].
* [cite_start]**Arquitectura de Herencia**: Uso de `enemy_base.gd` para definir comportamientos comunes (velocidad, daño, auto-limpieza al salir de pantalla) que heredan los tipos específicos[cite: 3].

## 🧬 Estructura de Clases (Scripts)

* [cite_start]`enemy_base.gd`: Clase maestra que gestiona el movimiento lineal hacia la izquierda y la detección de colisiones[cite: 3].
* [cite_start]`EnemySpawner.gd`: Controlador que gestiona la dificultad y frecuencia de aparición de enemigos[cite: 5].
* [cite_start]`player.gd`: Maneja el input del usuario y la actualización de estados de animación[cite: 5].
* [cite_start]**Variantes de Enemigos**: Scripts especializados para comportamientos `Normal`, `Fast`, `Heavy` y `Crowd`[cite: 3].

## 🛠️ Configuración de Escenas

* [cite_start]**Nivel Principal**: `level_01.tscn` utiliza capas de fondo y áreas de spawn delimitadas por marcadores (`Top`/`Bottom`) para garantizar que los enemigos aparezcan dentro del área de juego[cite: 4, 5].
* [cite_start]**Jugador**: Estructura `CharacterBody2D` con cámara integrada para seguimiento lateral automático[cite: 4].

## 📂 Organización del Proyecto

```text
res://
|_src
|  |_scripts/   # Lógica pura en GDScript
|  |_scenes/    # Escenas de enemigos, jugador y niveles
|  |_assets/    # Recursos visuales y auditivos (Placeholders)