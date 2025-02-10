FROM public.ecr.aws/lambda/python:3.10

COPY pyproject.toml uv.lock ${LAMBDA_TASK_ROOT}

RUN pip install uv

RUN uv pip install -r pyproject.toml --system

COPY . ${LAMBDA_TASK_ROOT}
