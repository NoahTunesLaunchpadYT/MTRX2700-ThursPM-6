################################################################################
# Automatically-generated file. Do not edit!
# Toolchain: GNU Tools for STM32 (11.3.rel1)
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
S_SRCS += \
../Src/3d_TransReceive.s \
../Src/3d_assembly.s \
../Src/3d_definitions.s \
../Src/3d_info.s 

OBJS += \
./Src/3d_TransReceive.o \
./Src/3d_assembly.o \
./Src/3d_definitions.o \
./Src/3d_info.o 

S_DEPS += \
./Src/3d_TransReceive.d \
./Src/3d_assembly.d \
./Src/3d_definitions.d \
./Src/3d_info.d 


# Each subdirectory must supply rules for building sources it contributes
Src/%.o: ../Src/%.s Src/subdir.mk
	arm-none-eabi-gcc -mcpu=cortex-m4 -g3 -DDEBUG -c -x assembler-with-cpp -MMD -MP -MF"$(@:%.o=%.d)" -MT"$@" --specs=nano.specs -mfpu=fpv4-sp-d16 -mfloat-abi=hard -mthumb -o "$@" "$<"

clean: clean-Src

clean-Src:
	-$(RM) ./Src/3d_TransReceive.d ./Src/3d_TransReceive.o ./Src/3d_assembly.d ./Src/3d_assembly.o ./Src/3d_definitions.d ./Src/3d_definitions.o ./Src/3d_info.d ./Src/3d_info.o

.PHONY: clean-Src

