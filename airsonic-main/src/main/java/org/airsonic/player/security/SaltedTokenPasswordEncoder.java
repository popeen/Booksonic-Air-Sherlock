package org.airsonic.player.security;

import org.apache.commons.codec.digest.DigestUtils;
import org.apache.commons.lang3.StringUtils;
import org.springframework.security.crypto.password.PasswordEncoder;

import java.util.function.Function;

public class SaltedTokenPasswordEncoder implements PasswordEncoder {
    private final Function<String, SaltToken> saltTokenExtractor;
    private final Function<String, String> encodingFunction;
    private final PasswordDecoder decoder;

    public SaltedTokenPasswordEncoder(Function<String, SaltToken> saltTokenExtractor,
            Function<String, String> encodingFunction, PasswordDecoder decoder) {
        this.saltTokenExtractor = saltTokenExtractor;
        this.encodingFunction = encodingFunction;
        this.decoder = decoder;
    }

    public SaltedTokenPasswordEncoder(PasswordDecoder decoder) {
        this(SaltToken::fromString, DigestUtils::md5Hex, decoder);
    }

    @Override
    public String encode(CharSequence rawPassword) {
        return encodingFunction.apply(rawPassword.toString());
    }

    @Override
    public boolean matches(CharSequence rawPassword, String encodedPassword) {
        SaltToken saltToken = saltTokenExtractor.apply(rawPassword.toString());
        String storedPassword = decoder.decode(encodedPassword);
        return StringUtils.equals(saltToken.getToken(), encode(storedPassword + saltToken.getSalt()));
    }
}
