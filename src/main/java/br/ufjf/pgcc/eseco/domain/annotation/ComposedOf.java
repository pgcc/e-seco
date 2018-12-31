package br.ufjf.pgcc.eseco.domain.annotation;

import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;

@Retention(RetentionPolicy.RUNTIME)
public @interface ComposedOf {
    Class<?>[] classes();
}
