/*
 * Copyright 2004, 2005, 2006 Acegi Technology Pty Limited
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

package org.airsonic.player.security;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.ldap.core.DirContextAdapter;
import org.springframework.ldap.core.DirContextOperations;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.ldap.ppolicy.PasswordPolicyControl;
import org.springframework.security.ldap.ppolicy.PasswordPolicyResponseControl;
import org.springframework.security.ldap.userdetails.LdapUserDetailsImpl;
import org.springframework.security.ldap.userdetails.UserDetailsContextMapper;

import java.util.Collection;

public class CustomUserDetailsContextMapper implements UserDetailsContextMapper {
    private static final Logger LOG = LoggerFactory.getLogger(CustomUserDetailsContextMapper.class);
    private String passwordAttributeName = "userPassword";

    @Override
    public UserDetails mapUserFromContext(DirContextOperations ctx, String username,
                                          Collection<? extends GrantedAuthority> authorities) {
        String dn = ctx.getNameInNamespace();

        LOG.debug("Mapping user details from context with DN: {}", dn);

        LdapUserDetailsImpl.Essence essence = new LdapUserDetailsImpl.Essence();
        essence.setDn(dn);

        Object passwordValue = ctx.getObjectAttribute(passwordAttributeName);

        if (passwordValue != null) {
            essence.setPassword(mapPassword(passwordValue));
        }

        essence.setUsername(username);

        // Add the supplied authorities
        for (GrantedAuthority authority : authorities) {
            essence.addAuthority(authority);
        }

        // Check for PPolicy data

        PasswordPolicyResponseControl ppolicy = (PasswordPolicyResponseControl) ctx
                .getObjectAttribute(PasswordPolicyControl.OID);

        if (ppolicy != null) {
            essence.setTimeBeforeExpiration(ppolicy.getTimeBeforeExpiration());
            essence.setGraceLoginsRemaining(ppolicy.getGraceLoginsRemaining());
        }

        return essence.createUserDetails();

    }

    @Override
    public void mapUserToContext(UserDetails user, DirContextAdapter ctx) {
        throw new UnsupportedOperationException(
                "LdapUserDetailsMapper only supports reading from a context. Please "
                        + "use a subclass if mapUserToContext() is required.");
    }

    /**
     * Extension point to allow customized creation of the user's password from the
     * attribute stored in the directory.
     *
     * @param passwordValue the value of the password attribute
     * @return a String representation of the password.
     */
    protected static String mapPassword(Object passwordValue) {

        if (!(passwordValue instanceof String)) {
            // Assume it's binary
            passwordValue = new String((byte[]) passwordValue);
        }

        return (String) passwordValue;

    }
}
