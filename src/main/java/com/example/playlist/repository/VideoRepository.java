package com.example.playlist.repository;

import com.example.playlist.model.Video;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface VideoRepository extends JpaRepository<Video, Long> {
    List<Video> findAllByOrderByFavoriteDescLikesDescCreatedAtDesc();
}
