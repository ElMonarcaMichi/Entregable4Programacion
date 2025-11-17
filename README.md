# Playlist de Videos de Música

Aplicación web en Java (Spring Boot) para gestionar una playlist de videos musicales con soporte para:

- Agregar y quitar videos (título + link)
- Visualización embebida (YouTube)
- Persistencia entre ejecuciones (H2 en archivo)
- UI atractiva con Bootstrap 5
- Likes por video
- Marcar/desmarcar como favorito

## Cómo ejecutar

Requisitos:
- Java 17+
- Maven 3.9+

Desde Windows PowerShell en la carpeta del proyecto:

```powershell
# Compilar y correr pruebas
mvn clean test

# Ejecutar la aplicación
mvn spring-boot:run
```

Luego abre http://localhost:8080 en el navegador.

Consola H2 (opcional): http://localhost:8080/h2-console  
URL JDBC: `jdbc:h2:file:./data/playlist`  Usuario: `sa`  Password: vacío

## Notas de implementación
- Se usa Spring Boot (Web, Thymeleaf, Data JPA) + H2.
- La entidad `Video` calcula el `embedUrl` a partir del link usando `YouTubeUtils` (acepta `watch?v=`, `youtu.be/`, `shorts/`, `embed/`).
- La lista se ordena: favoritos primero, luego por likes y más recientes.
- Likes y favoritos usan POST y redirección para mantener la vista simple y estable.

## Estructura principal
- `src/main/java/com/example/playlist/PlaylistApplication.java`: inicio de Spring Boot
- `src/main/java/com/example/playlist/model/Video.java`: entidad JPA
- `src/main/java/com/example/playlist/repository/VideoRepository.java`: repositorio JPA
- `src/main/java/com/example/playlist/service/VideoService.java`: lógica de negocio
- `src/main/java/com/example/playlist/controller/VideoController.java`: capa web
- `src/main/java/com/example/playlist/util/YouTubeUtils.java`: utilidades de YouTube
- `src/main/resources/templates/index.html`: UI con Bootstrap 5
- `src/main/resources/application.properties`: configuración de H2 y JPA
- `src/test/java/com/example/playlist/VideoServiceTests.java`: pruebas básicas

## Posibles mejoras
- Validación UI con mensajes por campo.
- Botones AJAX (htmx o fetch) para actualizar likes/favoritos sin recargar.
- Filtros/búsqueda y ordenamiento configurable.
- Soporte para otras plataformas de video.