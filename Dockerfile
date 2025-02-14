
FROM jupyter/base-notebook

COPY --from=neomantra/flatbuffers /usr/local/bin/flatc /usr/local/bin/flatc
COPY --from=neomantra/flatbuffers /usr/local/include/flatbuffers /usr/local/include/flatbuffers
COPY --from=neomantra/flatbuffers /usr/local/lib/libflatbuffers.a /usr/local/lib/libflatbuffers.a
COPY --from=neomantra/flatbuffers /usr/local/lib/cmake/flatbuffers /usr/local/lib/cmake/flatbuffers

USER 0
RUN apt-get update && apt-get install -y libhdf5-serial-dev git gcc g++ build-essential libblas-dev liblapack-dev libhdf5-dev pkg-config 
ENV NB_UID=1000
ENV NB_GID=100
USER 1000
COPY --chown=${NB_UID}:${NB_GID} requirements.txt requirements.txt
RUN pip install --no-cache-dir -r requirements.txt && \
    fix-permissions "${CONDA_DIR}" && \
    fix-permissions "/home/${NB_USER}"

RUN git clone https://bitbucket.org/kloostermannerflab/py-compressed-kde.git && cd py-compressed-kde/python && python3 setup.py build_ext --inplace  && pip install -e .	
RUN git clone https://penagos1@bitbucket.org/fk-decode/fklab-python-core.git && cd fklab-python-core && python3 setup.py build_ext --inplace && pip install -e . --no-deps
RUN git clone https://github.com/KatharinaBracher/HippocampalSWRDynamics.git && cd HippocampalSWRDynamics &&  pip install -e . --no-deps

RUN mkdir data

