import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns
import numpy as np
import sys

# Configurar estilo
plt.style.use('seaborn-v0_8-darkgrid')
sns.set_palette("husl")

def plot_latency_analysis(csv_file):
    # Leer datos
    df = pd.read_csv(csv_file)
    
    # Crear figura con subplots
    fig = plt.figure(figsize=(16, 12))
    fig.suptitle('Análisis de Latencia vs Tamaño de Payload', fontsize=16, fontweight='bold')
    
    # 1. Latencia media con std
    ax1 = plt.subplot(2, 2, 1)
    ax1.errorbar(df['payload_size'], df['mean_us'], 
                 yerr=df['stddev_us'], 
                 fmt='-o', linewidth=2, 
                 capsize=5, capthick=2,
                 label='Media ± σ')
    ax1.fill_between(df['payload_size'], 
                     df['mean_us'] - df['stddev_us'],
                     df['mean_us'] + df['stddev_us'],
                     alpha=0.2)
    ax1.set_xlabel('Tamaño de Payload (bytes)')
    ax1.set_ylabel('Latencia (μs)')
    ax1.set_title('Latencia Media y Desviación Estándar')
    ax1.legend()
    ax1.grid(True, alpha=0.3)
    
    # 2. Percentiles
    ax2 = plt.subplot(2, 2, 2)
    ax2.plot(df['payload_size'], df['p50_us'], 'g-', linewidth=3, label='P50 (Mediana)')
    ax2.plot(df['payload_size'], df['p95_us'], 'orange', '--', linewidth=2, label='P95')
    ax2.plot(df['payload_size'], df['p99_us'], 'r:', linewidth=2, label='P99')
    ax2.set_xlabel('Tamaño de Payload (bytes)')
    ax2.set_ylabel('Latencia (μs)')
    ax2.set_title('Percentiles de Latencia')
    ax2.legend()
    ax2.grid(True, alpha=0.3)
    
    # 3. Rango min-max
    ax3 = plt.subplot(2, 2, 3)
    ax3.fill_between(df['payload_size'], 
                     df['min_us'], 
                     df['max_us'],
                     alpha=0.3, color='purple',
                     label='Rango Min-Max')
    ax3.plot(df['payload_size'], df['mean_us'], 'b-', linewidth=2, label='Media')
    ax3.set_xlabel('Tamaño de Payload (bytes)')
    ax3.set_ylabel('Latencia (μs)')
    ax3.set_title('Rango de Latencia (Mínimo-Máximo)')
    ax3.legend()
    ax3.grid(True, alpha=0.3)
    
    # 4. Coeficiente de variación y throughput estimado
    ax4 = plt.subplot(2, 2, 4)
    
    # Coeficiente de variación (izquierda)
    ax4_twin = ax4.twinx()
    cv = (df['stddev_us'] / df['mean_us'] * 100)
    ax4.plot(df['payload_size'], cv, 'brown', '-o', linewidth=2, label='CV (%)')
    ax4.set_xlabel('Tamaño de Payload (bytes)')
    ax4.set_ylabel('Coef. Variación (%)', color='brown')
    ax4.tick_params(axis='y', labelcolor='brown')
    
    # Throughput estimado (derecha)
    # Throughput = (payload_size * 8 bits/byte) / (latencia * 1e-6) = bits/segundo
    throughput_mbps = (df['payload_size'] * 8) / (df['mean_us'] * 1e-6) / 1e6  # Convertir a Mbps
    ax4_twin.plot(df['payload_size'], throughput_mbps, 'green', '--', linewidth=2, label='Throughput')
    ax4_twin.set_ylabel('Throughput (Mbps)', color='green')
    ax4_twin.tick_params(axis='y', labelcolor='green')
    
    ax4.set_title('CV (%) y Throughput Estimado')
    
    # Combinar leyendas
    lines1, labels1 = ax4.get_legend_handles_labels()
    lines2, labels2 = ax4_twin.get_legend_handles_labels()
    ax4.legend(lines1 + lines2, labels1 + labels2, loc='upper left')
    
    ax4.grid(True, alpha=0.3)
    
    # Ajustar layout
    plt.tight_layout()
    plt.savefig('latency_analysis_python.png', dpi=300, bbox_inches='tight')
    plt.show()
    
    # Gráfico adicional: Distribución completa (último punto)
    fig2, ax = plt.subplots(figsize=(12, 8))
    
    # Para este gráfico necesitaríamos los datos crudos
    # Si guardas latencias individuales, puedes hacer histograma aquí
    
    ax.set_xlabel('Latencia (μs)')
    ax.set_ylabel('Frecuencia')
    ax.set_title('Distribución de Latencia para diferentes payloads')
    ax.grid(True, alpha=0.3)
    
    plt.tight_layout()
    plt.savefig('latency_distribution.png', dpi=300, bbox_inches='tight')
    
    # Imprimir estadísticas resumen
    print("\n" + "="*60)
    print("ESTADÍSTICAS RESUMEN")
    print("="*60)
    print(f"Total de puntos medidos: {len(df)}")
    print(f"Rango de payload: {df['payload_size'].min()} - {df['payload_size'].max()} bytes")
    print(f"Latencia mínima global: {df['min_us'].min():.2f} μs")
    print(f"Latencia máxima global: {df['max_us'].max():.2f} μs")
    print(f"Latencia media global: {df['mean_us'].mean():.2f} μs")
    
    # Encontrar mejor y peor caso
    best_idx = df['mean_us'].idxmin()
    worst_idx = df['mean_us'].idxmax()
    
    print(f"\nMejor caso: {df.loc[best_idx, 'mean_us']:.2f} μs @ {df.loc[best_idx, 'payload_size']} bytes")
    print(f"Peor caso:  {df.loc[worst_idx, 'mean_us']:.2f} μs @ {df.loc[worst_idx, 'payload_size']} bytes")

if __name__ == "__main__":
    if len(sys.argv) < 2:
        print("Uso: python plot_latency.py <archivo_csv>")
        print("Ejemplo: python plot_latency.py latency_results.csv")
        sys.exit(1)
    
    plot_latency_analysis(sys.argv[1])