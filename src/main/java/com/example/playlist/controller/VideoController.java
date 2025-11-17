package com.example.playlist.controller;

import com.example.playlist.service.VideoService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
public class VideoController {
    private final VideoService service;

    public VideoController(VideoService service) {
        this.service = service;
    }

    @GetMapping("/")
    public String index(@RequestParam(name = "page", defaultValue = "0") int page,
                        Model model) {
        int size = 12; // 3 x 4 grid per page
        var paged = service.listPaged(page, size);
        model.addAttribute("videos", paged.getContent());
        model.addAttribute("page", paged);
        // message and error are provided via flash attributes when present
        return "index";
    }

    @PostMapping("/videos")
    public String add(@RequestParam String title,
                      @RequestParam String url,
                      RedirectAttributes ra) {
        try {
            service.add(title, url);
            ra.addFlashAttribute("message", "Video agregado correctamente");
        } catch (IllegalArgumentException ex) {
            ra.addFlashAttribute("error", ex.getMessage());
        }
        return "redirect:/";
    }

    @PostMapping("/videos/{id}/delete")
    public String delete(@PathVariable Long id, RedirectAttributes ra) {
        service.delete(id);
        ra.addFlashAttribute("message", "Video eliminado");
        return "redirect:/";
    }

    @PostMapping("/videos/{id}/like")
    public String like(@PathVariable Long id, RedirectAttributes ra) {
        service.like(id);
        return "redirect:/";
    }

    @PostMapping("/videos/{id}/favorite")
    public String toggleFavorite(@PathVariable Long id) {
        service.toggleFavorite(id);
        return "redirect:/";
    }
}
