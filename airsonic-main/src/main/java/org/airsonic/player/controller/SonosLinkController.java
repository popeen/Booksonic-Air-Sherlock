/*
 * This file is part of Airsonic.
 *
 *  Airsonic is free software: you can redistribute it and/or modify
 *  it under the terms of the GNU General Public License as published by
 *  the Free Software Foundation, either version 3 of the License, or
 *  (at your option) any later version.
 *
 *  Airsonic is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *  GNU General Public License for more details.
 *
 *  You should have received a copy of the GNU General Public License
 *  along with Airsonic.  If not, see <http://www.gnu.org/licenses/>.
 *
 *  Copyright 2015 (C) Sindre Mehus
 */
package org.airsonic.player.controller;

import org.airsonic.player.service.SonosService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;

import java.util.Collections;
import java.util.HashMap;
import java.util.Map;

/**
 * Controller for the page used to administer the Sonos music service settings.
 *
 * @author Sindre Mehus
 */
@Controller
@RequestMapping("/sonoslink")
public class SonosLinkController {

    @Autowired
    private SonosService sonosService;
    @Autowired
    private AuthenticationManager authManager;

    @GetMapping
    public ModelAndView doGet(HttpServletRequest request) {
        String linkCode = request.getParameter("linkCode");

        String household = sonosService.getHouseholdId(linkCode);

        String view = household != null ? "sonosLinkLogin" : "sonosLinkNotFound";

        return new ModelAndView(view, "model", Map.of("linkCode", linkCode));
    }

    @PostMapping
    public ModelAndView doPost(HttpServletRequest request) {
        String linkCode = request.getParameter("linkCode");
        String username = request.getParameter("j_username");
        String password = request.getParameter("j_password");

        String household = sonosService.getHouseholdId(linkCode);
        if (household == null) {
            return new ModelAndView("sonosLinkNotFound", "model", Map.of("linkCode", linkCode));
        }

        try {
            Authentication authenticate = authManager.authenticate(new UsernamePasswordAuthenticationToken(username, password));
            if (authenticate.isAuthenticated()) {
                sonosService.addSonosAuthorization(username, household, linkCode);
                return new ModelAndView("sonosSuccess", "model", Collections.emptyMap());
            } else {
                return loginFailed(linkCode);
            }
        } catch (BadCredentialsException e) {
            return loginFailed(linkCode);
        }
    }

    private ModelAndView loginFailed(String linkCode) {
        Map<String, Object> model = new HashMap<>();
        model.put("linkCode", linkCode);
        model.put("error", true);

        return new ModelAndView("sonosLinkLogin", "model", model);
    }
}
