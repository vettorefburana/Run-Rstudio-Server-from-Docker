FROM rocker/verse:4.1.0

RUN apt-get clean all && \
  apt-get -o Acquire::Max-FutureTime=86400 update && \
  apt-get -o Acquire::Max-FutureTime=86400 upgrade -y && \
  apt-get -o Acquire::Max-FutureTime=86400 install -y \
    libhdf5-dev \
    libcurl4-gnutls-dev \
    libssl-dev \
    libxml2-dev \
    libpng-dev \
    libxt-dev \
    zlib1g-dev \
    libbz2-dev \
    liblzma-dev \
    libglpk40 \
    libgit2-28 \
  && apt-get clean all && \
  apt-get purge && \
  rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
 
RUN Rscript -e "install.packages(c('forecast', 'lubridate', 'ggplot2', 'xts', 'zoo'));"
 
COPY .Rprofile /home/rstudio/

