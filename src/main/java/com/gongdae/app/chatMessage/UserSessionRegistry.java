package com.gongdae.app.chatMessage;

import java.util.Map;
import java.util.Set;
import java.util.concurrent.ConcurrentHashMap;

import org.springframework.stereotype.Component;

@Component
public class UserSessionRegistry {
    private final Map<Long, Integer> onlineUsers = new ConcurrentHashMap<>();

    public void add(Long memberId) {
        onlineUsers.merge(memberId, 1, Integer::sum);
    }

    public void remove(Long memberId) {
        onlineUsers.computeIfPresent(memberId, (id, count) -> count > 1 ? count - 1 : null);
    }

    public boolean isOnline(Long memberId) {
        return onlineUsers.containsKey(memberId);
    }

    public Set<Long> getAllOnlineUsers() {
        return onlineUsers.keySet();
    }
}
