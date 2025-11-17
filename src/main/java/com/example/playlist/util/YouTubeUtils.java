package com.example.playlist.util;

import java.net.URI;
import java.net.URISyntaxException;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public final class YouTubeUtils {
    private YouTubeUtils() {}

    private static final Pattern WATCH_V_PATTERN = Pattern.compile("[?&]v=([a-zA-Z0-9_-]{11})");
    private static final Pattern SHORTS_PATTERN = Pattern.compile("/shorts/([a-zA-Z0-9_-]{11})");
    private static final Pattern EMBED_PATTERN = Pattern.compile("/embed/([a-zA-Z0-9_-]{11})");
    private static final Pattern YOUTU_BE_PATTERN = Pattern.compile("youtu\\.be/([a-zA-Z0-9_-]{11})");

    public static String toEmbedUrl(String url) {
        if (url == null || url.isBlank()) return null;
        String id = extractVideoId(url.trim());
        return id == null ? null : "https://www.youtube.com/embed/" + id;
    }

    public static String extractVideoId(String rawUrl) {
        String url = normalizeUrl(rawUrl);
        if (url == null) return null;

        Matcher m;
        // youtu.be/<id>
        m = YOUTU_BE_PATTERN.matcher(url);
        if (m.find()) return m.group(1);
        // youtube.com/embed/<id>
        m = EMBED_PATTERN.matcher(url);
        if (m.find()) return m.group(1);
        // youtube.com/shorts/<id>
        m = SHORTS_PATTERN.matcher(url);
        if (m.find()) return m.group(1);
        // youtube.com/watch?v=<id>
        m = WATCH_V_PATTERN.matcher(url);
        if (m.find()) return m.group(1);
        return null;
    }

    private static String normalizeUrl(String raw) {
        String trimmed = raw.trim();
        if (!trimmed.startsWith("http://") && !trimmed.startsWith("https://")) {
            trimmed = "https://" + trimmed;
        }
        try {
            URI uri = new URI(trimmed);
            String host = uri.getHost();
            if (host == null) return trimmed;
            // lowercase host
            host = host.toLowerCase();
            String rebuilt = uri.getScheme() + "://" + host + (uri.getRawPath() == null ? "" : uri.getRawPath())
                    + (uri.getRawQuery() == null ? "" : ("?" + uri.getRawQuery()));
            return rebuilt;
        } catch (URISyntaxException e) {
            return raw;
        }
    }
}
