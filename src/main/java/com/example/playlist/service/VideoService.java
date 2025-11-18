package com.example.playlist.service;

import com.example.playlist.model.Video;
import com.example.playlist.repository.VideoRepository;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Optional;




@Service
public class VideoService {
     
    private void validateId(Long id) throws IllegalArgumentException{
        if (id == null) throw new IllegalArgumentException("id requerido");
        if (id <= 0) throw new IllegalArgumentException("id debe ser positivo");
    }
    
    private final VideoRepository repository;

    public VideoService(VideoRepository repository) {
        this.repository = repository;
    }

    public List<Video> list() {
        return repository.findAllByOrderByFavoriteDescLikesDescCreatedAtDesc();
    }

    public Page<Video> listPaged(int page, int size) {
        int p = Math.max(0, page);
        int s = Math.max(1, size);
        Sort sort = Sort.by(
                Sort.Order.desc("favorite"),
                Sort.Order.desc("likes"),
                Sort.Order.desc("createdAt")
        );
        Pageable pageable = PageRequest.of(p, s, sort);
        return repository.findAll(pageable);
    }

    public Video add(String title, String url) {
        String cleanTitle = title == null ? "" : title.trim();
        String cleanUrl = url == null ? "" : url.trim();
        if (cleanTitle.isEmpty() || cleanUrl.isEmpty()) {
            throw new IllegalArgumentException("El título y el link son obligatorios");
        }
        Video v = new Video(cleanTitle, cleanUrl);
        return repository.save(v);
    }

    public void delete(Long id) {
        validateId(id);
        repository.deleteById(id);
    }

    public Optional<Video> get(Long id) {
        
        validateId(id);
        return repository.findById(id);
    }

    @Transactional
    public int like(Long id) {
    
        validateId(id);
        Video v = repository.findById(id).orElseThrow();
        v.setLikes(v.getLikes() + 1);
        // JPA dirty checking will persist on transaction commit
        return v.getLikes();
    }

    @Transactional
    public boolean toggleFavorite(Long id) {
        validateId(id);
        Video v = repository.findById(id).orElseThrow();
        v.setFavorite(!v.isFavorite());
        return v.isFavorite();
    }
}
