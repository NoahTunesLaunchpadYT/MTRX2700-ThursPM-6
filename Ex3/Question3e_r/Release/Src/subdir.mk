################################################################################
# Automatically-generated file. Do not edit!
# Toolchain: GNU Tools for STM32 (11.3.rel1)
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
S_SRCS += \
../Src/3e_assembly.s \
../Src/3e_communicate.s \
../Src/3e_definitions.s \
../Src/3e_info.s \
../Src/3e_receive.s 

OBJS += \
./Src/3e_assembly.o \
./Src/3e_communicate.o \
./Src/3e_definitions.o \
./Src/3e_info.o \
./Src/3e_receive.o 

S_DEPS += \
./Src/3e_assembly.d \
./Src/3e_communicate.d \
./Src/3e_definitions.d \
./Src/3e_info.d \
./Src/3e_receive.d 


# Each subdirectory must supply rules for building sources it contributes
Src/%.o: ../Src/%.s Src/subdir.mk
	arm-none-eabi-gcc -mcpu=cortex-m4 -c -x assembler-with-cpp -MMD -MP -MF"$(@:%.o=%.d)" -MT"$@" --specs=nano.specs -mfpu=fpv4-sp-d16 -mfloat-abi=hard -mthumb -o "$@" "$<"

clean: clean-Src

clean-Src:
	-$(RM) ./Src/3e_assembly.d ./Src/3e_assembly.o ./Src/3e_communicate.d ./Src/3e_communicate.o ./Src/3e_definitions.d ./Src/3e_definitions.o ./Src/3e_info.d ./Src/3e_info.o ./Src/3e_receive.d ./Src/3e_receive.o

.PHONY: clean-Src

