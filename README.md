# SonoCoin Protocol Documentation

Documentation is generated using reStructuredText targeting readthedocs.org.

## Dependencies

* Python
* Sphinx
* Sphinx Read the Docs Theme
* LaTeX

```
apt-get install python-sphinx
```

```
pip install sphinx_rtd_theme
```

```
apt-get install texlive-full  
```


### For live reloading

* Sphinx-Autobuild

```
pip install sphinx-autobuild
```

start with:
```
./live_reloading.sh
```

## Building Documentation Locally

```
make html
```


## Rst Cheat Sheet

### LaTex

```
.. math::

    \frac{a}{b}
```

### Info boxes

```
.. seealso::

    content

.. info::

    content

.. warnung::

    content
```

### Code Blocks

```
.. code-block::
    :linenos:

    #include<stdio.h>

    int main(){
        printf("hello world\n");
        return 0;
    }
```