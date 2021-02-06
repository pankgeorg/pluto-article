FROM julia:1.6-rc

EXPOSE 1234
RUN apt-get update -y && apt upgrade -y
RUN useradd -ms /bin/bash pluto
WORKDIR /home/pluto
USER pluto
COPY --chown=pluto . ${HOME}
RUN ls ${HOME}

RUN julia --project=${HOME} -e "import Pkg; Pkg.activate(\".\"); Pkg.instantiate(); Pkg.precompile()"

EXPOSE 1234

CMD ["julia", "--project=/home/pluto", "-e", "import PlutoBindServer; PlutoBindServer.run_directory(\".\"; port=1234 , host=\"0.0.0.0\", workspace_use_distributed=true)"]