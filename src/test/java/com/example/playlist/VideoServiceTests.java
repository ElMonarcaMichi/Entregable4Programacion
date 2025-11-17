package com.example.playlist;

import com.example.playlist.model.Video;
import com.example.playlist.repository.VideoRepository;
import com.example.playlist.service.VideoService;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.TestPropertySource;

import static org.junit.jupiter.api.Assertions.*;

@SpringBootTest
@TestPropertySource(properties = {
        "spring.datasource.url=jdbc:h2:mem:testdb;DB_CLOSE_DELAY=-1",
        "spring.jpa.hibernate.ddl-auto=create-drop"
})
class VideoServiceTests {

    @Autowired
    VideoService service;

    @Autowired
    VideoRepository repository;

    @BeforeEach
    void clean() {
        repository.deleteAll();
    }

    @Test
    void addVideo_andList() {
        service.add("Song A", "https://youtu.be/dQw4w9WgXcQ");
        assertEquals(1, service.list().size());
        Video v = service.list().get(0);
        assertEquals("Song A", v.getTitle());
        assertNotNull(v.getEmbedUrl());
    }

    @Test
    void likeVideo_incrementsCounter() {
        Video v = service.add("Song B", "https://www.youtube.com/watch?v=dQw4w9WgXcQ");
        int c1 = service.like(v.getId());
        int c2 = service.like(v.getId());
        assertEquals(1, c1);
        assertEquals(2, c2);
    Long id = v.getId();
    assertNotNull(id);
    var opt = repository.findById(id);
    assertTrue(opt.isPresent());
    assertEquals(2, opt.get().getLikes());
    }
}
